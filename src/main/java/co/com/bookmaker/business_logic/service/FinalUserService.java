/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package co.com.bookmaker.business_logic.service;

import co.com.bookmaker.business_logic.service.event.MatchEventService;
import co.com.bookmaker.business_logic.service.event.SportService;
import co.com.bookmaker.business_logic.service.event.TournamentService;
import co.com.bookmaker.business_logic.service.security.AuthenticationService;
import co.com.bookmaker.data_access.dao.FinalUserDAO;
import co.com.bookmaker.data_access.entity.Agency;
import co.com.bookmaker.data_access.entity.FinalUser;
import co.com.bookmaker.data_access.entity.event.Sport;
import co.com.bookmaker.data_access.entity.event.Tournament;
import co.com.bookmaker.util.type.Attribute;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import co.com.bookmaker.util.type.Role;
import co.com.bookmaker.util.type.Status;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author eduarc
 */
public class FinalUserService {

    private final FinalUserDAO finalUserDAO;
    private final AuthenticationService auth;
    private final SportService sportService;
    private final TournamentService tournamentService;
    private final MatchEventService matchEventService;
    
    public FinalUserService() {
        
        finalUserDAO = new FinalUserDAO();
        auth = new AuthenticationService();
        sportService = new SportService();
        tournamentService = new TournamentService();
        matchEventService = new MatchEventService();
    }
    
    public List<FinalUser> findAll() {
        return finalUserDAO.findAll();
    }
    
    public List<FinalUser> searchBy(HttpServletRequest request, String username, Long role, Integer status, boolean online) {
        
        List<String> attributes = new ArrayList();
        List<Object> values = new ArrayList();
        
        if (username != null) {
            attributes.add("username");
            values.add(username);
        }
        if (status != null) {
            attributes.add("status");
            values.add(status);
        }
        List<FinalUser> preliminar = finalUserDAO.findAll(attributes.toArray(new String[]{}), values.toArray());
        List<FinalUser> result = new ArrayList();
        for (FinalUser user : preliminar) {
            boolean add = true;
            if (role != null) {
                add &= user.inRole(role);
            }
            if (online == true) {
                add &= auth.isOnline(user, request);
            }
            if (add) {
                result.add(user);
            }
        }
        return result;
    }
    
    public FinalUser getLoginUser(String username, String password) {
        
        return finalUserDAO.find(new String[] {"username", "password"},
                                 new Object[] { username,   password});
    }
    
    public FinalUser find(Long id) {
        return finalUserDAO.find(id);
    }
    
    public FinalUser getUser(String username) {
        
        return finalUserDAO.find(new String[] {"username"},
                                 new Object[] { username});
    }
    
    public FinalUser getUser(String username, Agency agency) {
        
        return finalUserDAO.find(new String[] {"username", "agency.id"},
                                 new Object[] { username, agency.getId()});
    }
    
    public void setAttributes(FinalUser author, FinalUser user, 
            String username, String password, String email, Calendar birthDate, String firstName, String lastName, 
            String city, String telephone, String address, Integer status,
            boolean admin, boolean manager, boolean analyst, boolean seller, boolean client) {
        
        user.setAuthor(author);
        user.setUsername(username);
        user.setPassword(password);
        user.setEmail(email);
        user.setBirthDate(birthDate);
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setCity(city);
        user.setTelephone(telephone);
        user.setAddress(address);
        user.setStatus(status);
        
        user.removeRol(Role.ADMIN);
        if (admin) {
            user.addRol(Role.ADMIN);
        }
        user.removeRol(Role.MANAGER);
        if (manager) {
            user.addRol(Role.MANAGER);
        }
        user.removeRol(Role.ANALYST);
        if (analyst) {
            user.addRol(Role.ANALYST);
        }
        user.removeRol(Role.SELLER);
        if (seller) {
            user.addRol(Role.SELLER);
        }
        user.removeRol(Role.CLIENT);
        if (client) {
            user.addRol(Role.CLIENT);
        }
    }
    
    public FinalUser create(FinalUser user) {
        
        if (getUser(user.getUsername()) != null) {
            throw new IllegalArgumentException("Usuario "+user.getUsername()+" ya existe");
        }
        finalUserDAO.create(user);
        return user;
    }
    
    public FinalUser update(FinalUser user, String targetUsername) {
        
        String newUsername = user.getUsername();
        if (getUser(newUsername) != null && !newUsername.equals(targetUsername)) {
            throw new IllegalArgumentException("Usuario "+user.getUsername()+" ya existe");
        }
        finalUserDAO.edit(user);
        return user;
    }
    
    public FinalUser edit(FinalUser user) {
        
        finalUserDAO.edit(user);
        return user;
    }
    
    public void addClientData(HttpServletRequest request) {
        
        List<Sport> sports = sportService.getSports(Status.ACTIVE);
        List<Integer> countMatchesSport = new ArrayList();
        
        List<List<Tournament>> tournaments = new ArrayList();
        List<List<Integer>> countMatchesTournament = new ArrayList();
        
        for (int i = 0; i < sports.size(); i++) {
            Sport s = sports.get(i);
            
            List<Tournament> sTournaments = tournamentService.getTournaments(s.getId(), Status.ACTIVE);
            /*if (sTournaments.isEmpty()) {
                sports.remove(i);
                i--;
                continue;
            }*/
            List<Integer> countTournament = new ArrayList();
            
            int nSportMatches = 0;
            for (int j = 0; j < sTournaments.size(); j++) {
                Tournament t = sTournaments.get(j);
                
                int nTournamentMatches = matchEventService.countMatches(t, Status.ACTIVE);
                if (nTournamentMatches == 0) {
                    sTournaments.remove(j);
                    j--;
                    continue;
                }
                countTournament.add(nTournamentMatches);
                
                nSportMatches += nTournamentMatches;
            }
            tournaments.add(sTournaments);
            countMatchesSport.add(nSportMatches);
            countMatchesTournament.add(countTournament);
        }
        
        request.setAttribute(Attribute.SPORTS, sports);
        request.setAttribute(Attribute.TOURNAMENTS, tournaments);
        request.setAttribute(Attribute.COUNT_MATCHES_SPORT, countMatchesSport);
        request.setAttribute(Attribute.COUNT_MATCHES_TOURNAMENT, countMatchesTournament);
    }
}
